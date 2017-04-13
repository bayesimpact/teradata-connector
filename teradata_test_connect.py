"""Test Teradata drivers installation."""
import teradata


def create_td_connection():
    try:
        uda_exec = teradata.UdaExec(appName='Test', version=1, logConsole=True,
                                    logLevel="DEBUG", configureLogging=True)

        kw = {"ANSI": True}

        uda_exec.connect(
            password="pwd",
            driver="Teradata",
            method="odbc",
            charset="UTF8",
            username="uid",
            system="terdatahost",
            **kw
        )

        print('Teradata Connection Sucessful.')
        print('Drivers seem properly installed.')
    except teradata.DatabaseError as e:
        print('Drivers seem properly installed.')
    except OSError as e:
        print('CreateTDConnection:Failed to Conect to teradata server', e)
        print("status='Failed'")
        print(repr(e))


if __name__ == '__main__':
    create_td_connection()
