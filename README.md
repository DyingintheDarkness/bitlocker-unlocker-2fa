# bitlocker-unlocker-2fa


## Setup

Create a text file like example.txt and save in this order

```
2fa_key
secret_password
bitlocker_password
```

Encrypt the file using openssl

```
OpenSSL-1.1.1h_win32\openssl.exe aes-256-cbc -a -salt -pbkdf2 -in <filename>.txt -k "<secret_password>" -out enc.txt
```
Example:-
```
OpenSSL-1.1.1h_win32\openssl.exe aes-256-cbc -a -salt -pbkdf2 -in example.txt -k "password1234" -out enc.txt
```
You can change the encrypted filename on 2fa.bat then compile it to exe to change the encrypted filename (Default is enc.txt)

## Usage

Need Administrator Privileges to Run

```
bitunc.exe --unlock <pin code seperated by spaces> --password <secret_password>
```
Example:-
```
bitunc.exe --unlock 923 271 --password password1234
```

- You can directly change the openssl encryption methods used in 2fa.bat and compile it to exe or use it as batch file.
