FROM golang:latest as builder
RUN go get  -u -v  github.com/wudaoluo/getAddrIP
WORKDIR /go/src/github.com/wudaoluo/getAddrIP
RUN CGO_ENABLED=0 go build

FROM alpine:latest
MAINTAINER carlo "https://github.com/wudaoluo"
COPY --from=builder /go/src/github.com/wudaoluo/getAddrIP/getAddrIP .
RUN chmod +x getAddrIP
EXPOSE 80
ENTRYPOINT ["./getAddrIP"]
