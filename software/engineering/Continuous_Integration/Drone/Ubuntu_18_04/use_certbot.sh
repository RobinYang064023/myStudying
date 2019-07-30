echo "type in the domain name"
read ans
sudo certbot --nginx -d "$ans" -d www."$ans"
echo "add \"sudo certbot renew --dry-run\" as crontab for renew cert per 90 days."