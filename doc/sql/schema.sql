CREATE DATABASE IF NOT EXISTS mock_external;
USE mock_external;

CREATE TABLE company (
    id          INT             NOT NULL AUTO_INCREMENT,
    integration_type VARCHAR(10) NOT NULL COMMENT 'REST, DB, JAR',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE trace (
    id          INT             NOT NULL AUTO_INCREMENT,
    company_id  INT             NOT NULL,
    status      VARCHAR(10)     NOT NULL DEFAULT 'READY' COMMENT 'READY, SUCCESS, FAIL',
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_trace_company FOREIGN KEY (company_id) REFERENCES company (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE transmission (
    id                  INT             NOT NULL AUTO_INCREMENT,
    company_id          INT             NOT NULL,
    status              VARCHAR(10)     NOT NULL DEFAULT 'READY' COMMENT 'READY, SUCCESS, FAIL',
    retry_count         INT             NOT NULL DEFAULT 0,
    last_error_message  VARCHAR(500)    NULL,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_retry_at       DATETIME        NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_transmission_company FOREIGN KEY (company_id) REFERENCES company (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
