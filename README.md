## 이것은 무엇인가?
* AWS에서 MFA를 사용하는 경우에 awscli 에서 세션 토큰을 좀 더 편하게 쓸 수 있도록 도와주는 도구이다.

## 준비하기
* `~/.aws/credentials` 파일에서 `[default]` 프로파일 정보를 제거한 후에 `~/.aws/credentials.ini`라는 이름으로 복사한다.

## 사용법
* `profile`: 프로파일 이름
* `token_code`: OTP 토큰
```
aws_session_token.sh <profile> <token_code>
```

## 사용 예
* 아래 명령으로 `.aws/credentials` 파일을 생성한다.
```
$ aws_session_token.sh prof2 123456
```
* 프로파일명을 지정하지 않고 aws cli 명령을 실행한다.
```
$ aws s3 ls /
2018-08-01 21:37:53   10 Bytes a.txt
2018-08-01 21:37:53   10 Bytes b.txt
2018-08-01 21:37:53   10 Bytes c.txt
...
```
