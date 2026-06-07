# calling-terraform-modules-s3-pre-signed-url
In this demo , I will use lambda to generate one pre-singed URL for user to download with time limits , for example URL available in 1 hour

## Pre-signed URL 

It is a security mechanism in AWS S3 that allows you to securely share files that were originally "private" with others through a URL with temporary access permissions

是 AWS S3 的一种安全机制，允许你将原本“私有”的文件，通过一个带有临时访问权限的 URL，安全地分享给他人,就想一张“限时入场券”

s3 bucket block_public_acces is true , it means it's a private bucket 

## Usage

- The github actions deploy.yaml will automatically create pre-signed URL after PR merged to main

- You will get one URL from github actions workflow like this:

```shell
https://gxtcrxdj5cw3vnfr6ayliqry3i0vicic.lambda-url.us-east-1.on.aws/

```
- You need to add your file which store in the s3 private bucket after "/" also 
   with ?file=your_file_name
- for example , if your file name is "Maxwell_DevSecOps.pdf"
- then you need to add this to the pre-signed URL like this :
```shell
https://gxtcrxdj5cw3vnfr6ayliqry3i0vicic.lambda-url.us-east-1.on.aws/?file=Maxwell_DevSecOps.pdf

```
- paste this URL to the browser then hit enter you will get the generated URL like this:

![pre-signedURL](./pre-signedurl.png)

- copy ths URL then go to your terminal use curl to download

```shell
allen@192 devops % curl -o maxwell_pre_signed.pdf 'https://gxtcrxdj5cw3vnfr6ayliqry3i0vicic.lambda-url.us-east-1.on.aws/?file=Maxwell_DevSecOps.pdf'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1348  100  1348    0     0   1518      0 --:--:-- --:--:-- --:--:--  1519
allen@192 devops % 

```







