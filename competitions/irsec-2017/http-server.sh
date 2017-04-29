# Run scripts for HTTP server

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../scripts && pwd )"

$DIR/clear-aliases.sh
$DIR/clear-crontabs.sh
$DIR/secure-sshd.sh
$DIR/configure-ufw.sh 22/tcp,80/tcp 22/tcp,3306/tcp,9000/tcp
$DIR/backup-files.sh

