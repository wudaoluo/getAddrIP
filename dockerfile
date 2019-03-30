FROM golang:latest as builder
WORKDIR /go/src/github/wudaoluo/getAddrIP
RUN go get github.com/wudaoluo/getAddrIP
RUN go build

FROM alpine:latest
MAINTAINER carlo "https://github.com/wudaoluo"
COPY --from=builder /go/src/github/wudaoluo/getAddrIP/getAddrIP .
EXPOSR 80
ENTRYPOINT ["./getAddrIP"]