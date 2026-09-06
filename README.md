## 목적

- 외부 연동 업무 처리에 있어서 다양한 처리 방법을 시도, 특징을 파악
- 업무 처리 후 생성된 작업 결과를 회사별로 서로 다른 외부 API에 전달하는 상황을 가정하고, Batch 방식과 RabbitMQ 기반 비동기 방식을 구현하여 각각의 처리 흐름과 특징을 비교
- 재처리, 실패 처리를 적용하여 데이터의 정합성을 고려한 시스템 개발

## 아키텍처

1. batch 이용
   ![alt text](/doc/image/readme/Batch.png)
2. RabbitMQ 이용
   ![alt text](/doc/image/readme/RabbitMQ.png)

## 업무 프로젝트

### 기술스택

> Java21, Spring Boot4, Spring Data JPA, MariaDB, RabbitMQ, Docker

## 업무

- 특정 작업을 한 후 DB에 상태 로그를 남긴다.
  단, 회사별로 다른 외부 API에 전송해야 한다.<br>
  회사 A --->
- 작업 상태/결과를 조회한다.
  작업 상태 (READY, SUCCESS, FAIL)

## ERD

```Mermaid
erDiagram
    COMPANY {
        int id PK
        string integration_type "REST, DB, JAR"
    }

    TRACE {
        int id PK
        int company_id FK
        string status "READY, SUCCESS, FAIL"
        datetime created_at
    }

    TRANSMISSION {
        int id PK
        int company_id FK
        string status "READY, SUCCESS, FAIL"
        int retry_count
        string last_error_message
        datetime created_at
        datetime updated_at
        datetime last_retry_at
    }


    COMPANY ||--o{ TRACE : ""
    COMPANY ||--o{ TRANSMISSION: ""
```

## Batch 방식

## RabbitMQ 방식

## 확장

- 타입별(REST, DB, JAR) 외부 연동 구현해보기 (외부 db에 저장)
