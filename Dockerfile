FROM golang:1.20.6

WORKDIR /usr/src/app 

COPY . .

RUN go mod tidy
RUN go build -o /usr/local/bin/app cmd/*.go

EXPOSE 3000

WORKDIR /usr/local/bin

CMD ["sh", "-c", "app"]
