
# Usefull Commands

## Date in seconds since unix epoch

```
date +%s
```

## base64 endcode

```
echo  -n "hi" | base64 | base64 -d | hexdump -C
```

```
echo -n "moq://moq-time.arpa/time-v1/" | base64
```

```
ifconfig en0 | grep ether | sed -e "s/.*ether /mac:/" | tr -d '\n' | base64
```

