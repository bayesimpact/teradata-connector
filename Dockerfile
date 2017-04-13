FROM centos:7

USER root

# Install dev tools.
RUN yum update -y && yum clean all

# Install specific libs requires for Python to build
RUN yum install -y gcc gcc++ kernel-devel make
RUN yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
RUN yum install -y libxml2-devel libxml++-devel python-devel

# Download Python and compile
RUN cd /opt \
    && curl -O https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tar.xz \
    && tar xf Python-3.4.2.tar.xz && cd Python-3.4.2 \
    &&./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
    && make \
    && make altinstall && cd /opt \
    && rm -f Python-3.4.2.tar.xz \
    && rm -rf Python-3.4.2/

# Install Teradata Drivers
RUN yum -y install ksh
COPY ./tdodbc1510__linux_indep.15.10.01.05-1.tar /code/
COPY ./install_teradata_drivers.sh /code/
RUN bash /code/install_teradata_drivers.sh
# Add path to Teradata Drivers.
ENV ODBCINI /app/vendored/teradata/client/ODBC_64/odbc.ini
ENV ODBCINST /app/vendored/teradata/client/ODBC_64/odbcinst.ini
# RUN epxort ODBCINI
# RUN export ODBCINST

# Install Pip
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py

# Install Jupyter Notebook
RUN python -m pip install --upgrade --force pip
RUN pip install jupyter

# Install Main Requirements
COPY ./requirements.txt /code/
RUN pip install -r /code/requirements.txt

# Configure environment
ENV SHELL /bin/bash
ENV NB_USER nbuser
ENV NB_UID 1000
ENV HOME /home/$NB_USER

# Create user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

# Setup user home directory
RUN mkdir /home/$NB_USER/.jupyter
RUN mkdir /home/$NB_USER/.local
WORKDIR /home/$NB_USER/work
EXPOSE 8888

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter
RUN chown -R $NB_USER:users /home/$NB_USER/.local
RUN chmod +x /usr/local/bin/start-notebook.sh
