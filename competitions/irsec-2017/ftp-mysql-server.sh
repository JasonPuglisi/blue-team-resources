# Run scripts for FTP/MySQL server

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../scripts && pwd )"

$DIR/clear-aliases.sh
$DIR/clear-crontabs.sh
$DIR/secure-sshd.sh
$DIR/configure-ufw.sh 20/tcp,21/tcp,22/tcp,3306/tcp 22/tcp,514/tcp,1514/tcp,9000/tcp
$DIR/backup-files.sh

