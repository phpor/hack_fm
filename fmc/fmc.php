<?php

function send($act) {
                $fp = fsockopen("localhost", 10098, $errno, $error, 8);
                fputs($fp, $act);
		if ($act == "end") {
			fclose($fp);
			return  '{"status":"end ok"}';
		}
		$result = fgetc($fp);
		$i = 1;
		while($i>0) {
			$c = fgetc($fp);
			if ($c == "{") $i++;
			if ($c == "}") $i--;
			$result .= $c;
		}
                fclose($fp);
                return $result;
}
echo send($argv[1]);
