FROM golang:1.18-alpine as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod go.sum ./

ENV GOPROXY https://proxy.golang.org,direct
RUN go mod download

COPY . .

ENV CGO_ENABLED=0
RUN GOOS=linux go build ./desafio.go

FROM scratch

WORKDIR /app

COPY --from=builder /app/desafio .

CMD ["/app/desafio"]