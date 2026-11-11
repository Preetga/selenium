FROM maven:3.9.9-eclipse-temurin-17

RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium chromium-driver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
COPY src ./src
COPY webpage ./webpage

RUN mvn --batch-mode dependency:go-offline

ENV CHROME_BIN=/usr/bin/chromium

CMD ["mvn", "--batch-mode", "test"]
