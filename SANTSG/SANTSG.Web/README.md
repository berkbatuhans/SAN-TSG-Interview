### API Task

- [x] .NET Core
- [x] POST Method Request
- [ ] When POST to any JSON body API, you need to print the JSON from the request to any file or database.

Postman:

Localhost: Postman ile istek gönderirken SSL certificate verification kısmını OFF yapıyoruz.  

#### POST / https://localhost:5001/api/reservation

| KEY          | VALUE            |
| ------------ | ---------------- |
| Content-Type | application/json |

**Example Body**

`[`
    `{`
        `"operator": {`
            `"code": "AMOR",`
            `"name": "AMOR REISE GMBH"`
        `},`
        `"voucherNo": 0`
    `}`
`]`