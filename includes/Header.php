<?php
$DOMAIN="http://thomaspreece.com";


function auto_version($file)
{
  if(strpos($file, '/') !== 0 || !file_exists($_SERVER['DOCUMENT_ROOT'] . $file))
    return $file;

  $mtime = filemtime($_SERVER['DOCUMENT_ROOT'] . $file);
  return preg_replace('{\\.([^./]+)$}', ".$mtime.\$1", $file);
}


//Echo Header
Echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<html>
<head>
<meta name=\"Description\" content=\"".$MetaDescription."\" />
<meta name=\"Keywords\" content=\"".$MetaKeywords."\" />
<meta http-equiv=\"content-language\" content=\"en-US\" />
<title>".$MetaTitle."</title>
";


//Load CSS
echo "
<link rel=\"stylesheet\" href=\"".$DOMAIN.auto_version('/css/MainStyle.css')."\" type=\"text/css\" media=\"screen\" />
";



//Load JS
echo "
<script src=\"".$DOMAIN.auto_version('/scripts/jquery-1.10.2_min.js')."\"></script>
";


switch ($PageName) {
	Case "work.php":
		echo "
		<link rel=\"stylesheet\" href=\"".$DOMAIN.auto_version('/css/mosaic.1.0.1.css')."\" type=\"text/css\" media=\"screen\" />
		<script src=\"".$DOMAIN.auto_version('/scripts/mosaic.1.0.1_min.js')."\"></script>
		

		<script type=\"text/javascript\">
		jQuery(function($){
			$('.fadeMosaic').mosaic();
		});
		</script>

<link rel=\"stylesheet\" href=\"".$DOMAIN.auto_version('/css/nyroModal.css')."\" type=\"text/css\" media=\"screen\" />
<script type=\"text/javascript\" src=\"".$DOMAIN.auto_version('/scripts/jquery.nyroModal.custom.js')."\"></script>
<!--[if IE 6]>
	<script type=\"text/javascript\" src=\"".$DOMAIN.auto_version('/scripts/jquery.nyroModal-ie6.min.js')."\"></script>
<![endif]-->
<script type=\"text/javascript\">
$(function() {
$('.nyroModal').nyroModal();

});
</script>

		";
		break;

	Case "index.php":

		echo "
		<link rel=\"stylesheet\" href=\"".$DOMAIN.auto_version('/css/js-image-slider.css')."\" type=\"text/css\" media=\"screen\" />
		<script src=\"".$DOMAIN.auto_version('/scripts/js-image-slider.js')."\"></script>
		";
		break;


}



//Continue Head
Echo "</head>

<body>


<div class='centerBody'>

<div class='underlinemenu'>
<div style='width:1000px;margin-right:auto;margin-left:auto;'>
<ul>
<li class='Logo'>
<!--<img style='height:50px;' src='".$DOMAIN."/Resources/Logo.png' />-->
</li>

<li><a href='".$DOMAIN."/contact.php' "; if($PageName=="contact.php"){echo "class='selected'";} echo ">Contact Me</a></li>
<li><a href='".$DOMAIN."/thesis.php' "; if($PageName=="thesis.php"){echo "class='selected'";} echo ">Mathematics</a></li>
<li><a href='".$DOMAIN."/resources.php' "; if($PageName=="resources.php"){echo "class='selected'";} echo ">Arduino</a></li>
<li><a href='".$DOMAIN."/work.php' "; if($PageName=="work.php"){echo "class='selected'";} echo ">Portfolio</a></li>
<li><a href='".$DOMAIN."/index.php' "; if($PageName=="index.php"){echo "class='selected'";} echo ">About Me</a></li>


</ul>
</div>
</div>
<!--<div style='height:30px;'></div>-->
<div class='contentBody'>";

?>