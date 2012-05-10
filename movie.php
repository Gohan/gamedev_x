
<?php 
function DOMinnerHTML($element) 
{ 
    $innerHTML = ""; 
    $children = $element->childNodes; 
    foreach ($children as $child) 
    { 
        $tmp_dom = new DOMDocument(); 
        $tmp_dom->appendChild($tmp_dom->importNode($child, true)); 
        $innerHTML.=trim($tmp_dom->saveHTML()); 
    } 
    return $innerHTML; 
} 
?>


<?php
    print("test\n");

    $movieid = 609;
    $areaid = 509;
    $showDate = '2012-05-12';
    $showTime = 0;
    $cinema = 'undefined';

    $postData = array('movie' =>  $movieid,
                                    'area' => $areaid,
                                    'showDate' => $showDate,
                                    'showTime' => $showTime,
                                    'cinema' => 'undefined');


    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'http://www.leying365.com/movie/online-list');
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_REFERER, 'http://www.leying365.com/movie/609.html');
    curl_setopt($ch, CURLOPT_COOKIEFILE, 'cookies.txt');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);

    $result = curl_exec($ch);

    $httpResponse = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    //echo $httpResponse;
    //echo $result;

    curl_close($ch);


    $dom_document = new DOMDocument();
    $meta = '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>';
    $dom_document->loadHTML($meta . $result);

    $dom_xpath = new DOMXpath($dom_document);

    $elements = $dom_xpath->query("//*[contains(@id,'open')]/table");

    echo $result;

    if (!is_null($elements)) {
        foreach ($elements as $e) {
            echo $e->saveHTML();
            echo DOMinnerHTML($e);
            $nodes = $e->childNodes;
            foreach ($nodes as $node) {
                //echo $node->nodeValue. "<BR>";
            }
        }
    }
            
            

    print_r($dom_document);
    echo $dom_document;
    
    
?>
