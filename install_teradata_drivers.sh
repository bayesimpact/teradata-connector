# Install Teradata drivers.

mkdir -p /app/install/
mkdir -p /app/vendored/
cd /code/

tar -xf tdodbc1510__linux_indep.15.10.01.05-1.tar
tar -xf tdodbc1510__linux_indep.15.10.01.05-1.tar.gz
tar xf TeraGSS_linux_x64__linux_indep.15.10.04.02-1.tar.gz
tar xf tdicu1510__linux_indep.15.10.01.02-1.tar.gz

#Install GSS
cd TeraGSS
rpm --prefix=/app/vendored/ -i TeraGSS_linux_x64-15.10.04.02-1.noarch.rpm


#Install TDICU using the setup wrapper script
cd ../tdicu1510
./setup_wrapper.sh -i /app/vendored

#Install the TDODBC Drivers using the defaults
cd ../tdodbc1510
# ./setup_wrapper.sh -i /app/vendored
rpm --prefix=/app/vendored/ -i tdodbc1510-15.10.01.05-1.noarch.rpm

# Bundle up the installed dependencies into a tar file
cd /app/vendored
tar cf teradata.tar teradata/
