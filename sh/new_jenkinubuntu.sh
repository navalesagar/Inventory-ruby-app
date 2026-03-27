sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version
#if jenkins installed and failed 
#sudo apt-key del 7198F4B714ABFC68 2>/dev/null || true
#sudo rm -f /usr/share/keyrings/jenkins*
#sudo rm -f /etc/apt/sources.list.d/jenkins.list


curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
| sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg


echo "deb [signed-by=/usr/share/keyrings/jenkins.gpg] https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list

sudo rm -rf /var/lib/apt/lists/*

sudo apt update
sudo apt install jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins