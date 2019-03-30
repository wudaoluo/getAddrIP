FROM golang:latest as builder
WORKDIR /go/src/github.com/wudaoluo/getAddrIP
RUN go get  -u -v  github.com/wudaoluo/getAddrIP
RUN go build

FROM alpine:latest
MAINTAINER carlo "https://github.com/wudaoluo"
COPY --from=builder /go/src/github/wudaoluo/getAddrIP/getAddrIP .
EXPOSE 80
ENTRYPOINT ["./getAddrIP"]
