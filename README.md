# SAN TSG Interview

## API [source code](https://github.com/berkbatuhans/SAN-TSG-Interview/tree/master/SANTSG)

### Task

- [x] .NET Core
- [x] POST Method Request [go to attribute](https://github.com/berkbatuhans/SAN-TSG-Interview/blob/bd58f9af13fdef4dfcf23a3c9cadd197ecf03ae0/SANTSG/SANTSG.Web/Controllers/ReservationController.cs#L82)
- [x] When POST to any JSON body API, you need to print the JSON from the request to any file or database. [go to code block](https://github.com/berkbatuhans/SAN-TSG-Interview/blob/master/SANTSG/SANTSG.Web/Controllers/ReservationController.cs#L82-L130)

### How to use?

#### Postman Settings

When sending the request, we set SSL certificate verification to OFF if it is ON.

![](https://raw.githubusercontent.com/berkbatuhans/SAN-TSG-Interview/master/screenshoots/postman_settings.png)

#### [Postman Collections Example](https://www.getpostman.com/collections/e116955957459a325681)

#### POST / https://localhost:5001/api/reservation

| KEY          | VALUE            |
| ------------ | ---------------- |
| Content-Type | application/json |

**Example Body**

```json
[
    {
        "operator": {
            "code": "AMOR",
            "name": "AMOR REISE GMBH"
        },
        "voucherNo": 0
    }
]
```



If the request is successful, it adds log records to the [**reservationFile.txt**](https://github.com/berkbatuhans/SAN-TSG-Interview/tree/master/SANTSG/SANTSG.Web/reservationFiles/reservationFile.txt) file in the [**reservationFiles**](https://github.com/berkbatuhans/SAN-TSG-Interview/tree/master/SANTSG/SANTSG.Web/reservationFiles) folder.



## SQL [source code](https://github.com/berkbatuhans/SAN-TSG-Interview/tree/master/SQL)

Comments are added to the lines of code.

#### How to use SQL Server with a Docker container this Image

```ruby
docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=123456! -e TZ=Europe/Minsk -p 1433:1433 --name sqlserver -d microsoft/mssql-server-linux:latest
```

#### How to use [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is?view=sql-server-ver15) 

SQL Server Management Tool for Mac

[Homebrew](https://formulae.brew.sh/cask/azure-data-studio)

```ruby
brew cask install azure-data-studio
```

