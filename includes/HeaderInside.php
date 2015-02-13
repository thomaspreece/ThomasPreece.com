<?php
$DOMAIN="http://127.0.0.1/ThomasPreece.com";


function auto_version($file)
{
  if(strpos($file, '/') !== 0 || !file_exists($_SERVER['DOCUMENT_ROOT'] . $file))
    return $file;

  $mtime = filemtime($_SERVER['DOCUMENT_ROOT'] . $file);
  return preg_replace('{\\.([^./]+)$}', ".$mtime.\$1", $file);
}



echo "
<link rel=\"stylesheet\" href=\"".$DOMAIN.auto_version('/css/MainStyle.css')."\" type=\"text/css\" media=\"screen\" />
";



?>