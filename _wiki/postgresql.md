---
layout  : wiki
title   : 
summary : 
date    : 2024-03-06 09:25:53 +0900
updated : 2024-03-06 09:32:25 +0900
tag     : 
toc     : true
public  : true
parent  : 
latex   : false
resource: A4A2C1CA-98BC-4564-8FF0-5EE5CDE2C42B
---
* TOC
{:toc}

# [psql Meta-Commands](https://www.postgresql.org/docs/current/app-psql.html)
backslash로 시작하는 명령어들을 meta-command라고 한다. 

drgs+ 명령어
> Lists information about each granted role membership, including assigned options (ADMIN, INHERIT and/or SET) and grantor. See the GRANT command for information about role memberships. By default, only grants to user-created roles are shown; supply the S modifier to include system roles. If pattern is specified, only grants to those roles whose names match the pattern are listed.
```sql
\drgS 
```
유저와 role 정보를 출력해준다.

# [sql command](https://www.postgresql.org/docs/16/sql-commands.html)
일반적으로 사용하는 sql 명령어들

