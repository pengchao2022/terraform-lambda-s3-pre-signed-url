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
curl -o maxwell_pre_signed.pdf 'https://maxwell-presign-url-2027.s3.amazonaws.com/Maxwell_DevSecOps.pdf?AWSAccessKeyId=ASIAUT2CHTJWJPKPNDLN&Signature=SJTMh1byZc1WIMTYAWiC%2BSx7RWs%3D&x-amz-security-token=IQoJb3JpZ2luX2VjENb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIH3%2FN1IAinFkUVVsbWoBxw%2FlJFtke9U9a4m%2F4WFyAjA0AiEA7zZnLGqj8S%2FkC704M1sRcqsSFQy0OChWPOSvz%2F0LH20q7wMIn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwzMTc0Mjk2MTkzMDgiDMuTf2Kx0ZDdntYDnirDA7aC%2BrJAPB6sMxD3TMce0MlAv8hVYBMwizPFxTRDib2HcYRgHMbMjLiOgrmQII0UPcmwIpdy6kCuOgH4eaI%2B3OIkFw5opu%2F2Y6iXW5MBODvhbcVugS9B87igl%2FCTUnrsbB4rrpvlJWpcTwCUxHIAhys9Q6MtuggTb2G5%2FzZO1h77xuJYK%2FhquHjmmRfDZBvuFGXlPu4CVS%2FNYixDH9LGFcOoZr1NJM7Ylw1kWPedJA0rS9CWea3RLAOxoZqo%2FxswWWPoYdYuVEJ8gkGstzukhQyjRPWqk%2BquEjEVj3WNLvUByLTPBWwja0oRiehyWRjYTX3XL8wT7A2KubgqK9kXk6pTtn9hoPxwnrwumV%2B7ynoWEMkdrt2oITOWKeEQBdxqhAPxMoeqpxnhI0lLLBEXeqyvtVG3wOzGTllk%2Fm2JVs%2B%2BJ47m0LHyxmewRWcD51ZD3vcr3A22MY35opcRSVBAi5h2V1j83W%2FBx2DzmCfaVqoFqH0LsEiwjoi4dI21bEBjQdpca8yTVPM718FKBL1ThaNJvAyzoDrWJZxfUiDcm7AcLAwQz5qlKf80ciRxmbDtiiihgLy3K65JIl5d3pKvtne3vrcwneeV0QY6oQFsTDkYsIBorsn1ohi63kFkGEj08xsBU53AVF4mYMWzt9ipIU91oPahnxpkxchYsgS8BB8GNgHDv9zVOXBI3nXt7PR8Yyz%2FJj5yrgUuUpaKxEB9nr7oSjuXj3dPmAR3%2BTDcXsdyB0jbO3UfV8slOkvOz%2FW55SRCSDiBX%2FPRLfpc1vFFijVtZxRWTgJ70SjU6tH9XqTRu5lzzb9w4xM%2FK3p5pA%3D%3D&Expires=1780843066'  
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  150k  100  150k    0     0  50786      0  0:00:03  0:00:03 --:--:-- 50801
allen@192 devops % 


```







