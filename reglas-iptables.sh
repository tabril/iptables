#!/bin/bash

# Elimina reglas de tabla filter
#iptables -t filter -F

# reinicia contadores tabla filter
#iptables -t filter -Z

# Politica Denegar trafico cadenas de filter (INPUT, OUTPUT)
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Aceptar paquetes de datos con estado relacionando y establecido
iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# habilitar interfaz loopback en systemd-resolve
iptables -I INPUT 1 -i lo -j ACCEPT
iptables -I OUTPUT 1 -o lo -j ACCEPT

#PING
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# iptables -t filter -A INPUT -p udp --sport 53 -j DROP
# iptables -t filter -A OUTPUT -p udp --dport 53 -j DROP
# iptables -t filter -A INPUT -p tcp --sport 53 -j DROP
# iptables -t filter -A OUTPUT -p tcp --dport 53 -j DROP

# DNS GOOGLE
iptables -t filter -A OUTPUT -d 8.8.8.8 -p udp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 8.8.4.4 -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -s 8.8.8.8 -p udp --sport 53 -j ACCEPT
iptables -t filter -A INPUT -s 8.8.4.4 -p udp --sport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 8.8.8.8 -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 8.8.4.4 -p tcp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -s 8.8.8.8 -p tcp --sport 53 -j ACCEPT
iptables -t filter -A INPUT -s 8.8.4.4 -p tcp --sport 53 -j ACCEPT

# DNS CLOUDFARE
iptables -t filter -A OUTPUT -d 1.1.1.1 -p udp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 1.0.0.1 -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -s 1.1.1.1 -p udp --sport 53 -j ACCEPT
iptables -t filter -A INPUT -s 1.0.0.1 -p udp --sport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 1.1.1.1 -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -d 1.0.0.1 -p tcp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -s 1.1.1.1 -p tcp --sport 53 -j ACCEPT
iptables -t filter -A INPUT -s 1.0.0.1 -p tcp --sport 53 -j ACCEPT

# Trafico HTTP
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT

# Trafico HTTPS
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A INPUT -p tcp --sport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

iptables -t filter -A INPUT -p tcp -m multiport --sports 1024:65534 -j ACCEPT
iptables -t filter -A INPUT -p udp -m multiport --sports 1024:65534 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp -m multiport --dports 1024:65534 -j ACCEPT
iptables -t filter -A OUTPUT -p udp -m multiport --dports 1024:65534 -j ACCEPT

