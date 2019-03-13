sudo docker pull drone/drone
sudo mkdir /etc/drone
LC_ALL=C </dev/urandom tr -dc A-Za-z0-9 | head -c 65 && echo
echo "Create /etc/drone/server.env by su and set variables below."
echo "\
# Service settings
DRONE_SECRET=secret_generated_on_command_line
DRONE_HOST=https://example.com

# Registration settings
DRONE_OPEN=false
DRONE_ADMIN=sammytheshark

# GitHub Settings
DRONE_GITHUB=true
DRONE_GITHUB_CLIENT=Client_ID_from_GitHub
DRONE_GITHUB_SECRET=Client_Secret_from_GitHub"

echo "Then, configure Drone Agent's env(/etc/drone/agent.env)."
echo "\
DRONE_SECRET=secret_generated_on_command_line
DRONE_SERVER=wss://example.com/ws/broker"

echo "Next, configure Drone Systemd unit file(/etc/systemd/system/drone.service)"
echo "\
[Unit]
Description=Drone server
After=docker.service nginx.service

[Service]
Restart=always
ExecStart=/usr/local/bin/docker-compose -f /etc/drone/docker-compose.yml up
ExecStop=/usr/local/bin/docker-compose -f /etc/drone/docker-compose.yml stop

[Install]
WantedBy=multi-user.target"

echo "Finally, you have to configure Nginx to proxy requests to Drone."
echo "sites-enabled is below."
grep -R server_name /etc/nginx/sites-enabled
echo "Modify the /etc/nginx/sites-enabled/default"