#! /bin/env php
<?php
/**
 * 翻以前的拆解与翻译后的还原
 *
 * @package timandes\enterprise
 */

ini_set('display_errors', true);
error_reporting(E_ALL);
ini_set('memory_limit', '4096M');

define('EXIT_SUCCESS', 0);
define('EXIT_FAILURE', 1);

$GLOBALS['gaSettings'] = array(
        'verbose' => 3,
    );

require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/config_admin.php';
require_once __DIR__ . '/enterprise_translate.h.php';

function main($argc, $argv)
{
    $html = <<<'EOT'
<p style="text-align:center"><strong><span style="color:#c0392b"><span style="font-size:48px"><span style="font-family:Arial,Helvetica,sans-serif">Transparent tray protective film jumbo roll</span></span></span></strong></p><p><strong>What is the detail of our stretch film?</strong></p><p><strong>1. With high transparency, no discoloration, good self-adhesive, good retraction ratio, good tensile properties, 1 meter can be on 5 meters use.</strong><br /><strong>2. Non-toxic, tear-resistant, anti-puncture, hot temperature endurable;</strong><br /><strong>3. Water-proof, moisture-proof, anti-corrosion. It is easy to use and remove, suitable for palletized packing of products and transportation operation, it also can be applied a large range of products for surface protection.</strong><br /><strong>4. This is Pallet Wrap Film (LLDPE Stretch Film) produced by three layer common extruding machine, it provided excellent protection for the surface of packed products. It can reduce packaging cost, its economical, labor saving. Efficiency increasing</strong></p><p> </p><p><strong><img src="https://timg.china.cn/0/1_346_47087_600_600.jpg" /></strong></p><p><strong><img src="https://timg.china.cn/0/1_42_46424_600_600.jpg" /></strong></p><p><strong>Features of LLDPE Clear Packing Wrap Cast Stretch Film</strong></p><p><strong>1, high resilience, transparency, and tensile strength with good gloss</strong></p><p><strong>2, the property of one-sided stickiness and double-sided stickiness</strong></p><p><strong>3, light weight, thin thickness</strong></p><p><strong>4, strong tear and impaling resistance; cold, heat and pressure resistance</strong></p><p><strong>5, dust, damp, scattering and falling proof, prevention of burglary</strong></p><p><strong>6, good autohension and high retraction, packing the cargo to a body and preventing the cargo damage at the same time.</strong></p><p><strong>7, material, labor, time and cost saving, efficient</strong></p><p><strong>8, non-toxic, odorless, good security, convenient to use</strong></p><p><strong>9, fast shrinkage under low temperature; good sealing under high speed</strong></p><p><strong>10, long retention time; completely recyclable and ecological environment protection</strong></p><p><strong><img src="https://timg.china.cn/0/1_263_46603_600_529.jpg" /></strong></p><p><strong>Product Display of  Stretch Film </strong></p><p><img src="https://timg.china.cn/0/1_166_46889_600_600.jpg" /><img src="https://timg.china.cn/0/1_826_46963_600_600.jpg" /></p><p> </p><p><strong>Data Sheet of LLDPE Clear Packing Wrap Cast Stretch Film</strong></p><table>   <tbody>     <tr>            <td>            <p><strong>Material:</strong></p>           </td>           <td>            <p><strong>LLDPE</strong></p>           </td>       </tr>       <tr>            <td>            <p><strong>Type:</strong></p>           </td>           <td>            <p><strong>Stretch Film</strong></p>            </td>       </tr>       <tr>            <td>            <p><strong>Usage:</strong></p>          </td>           <td>            <p><strong>Packaging Film</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Feature:</strong></p>            </td>           <td>            <p><strong>Moisture Proof</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Hardness:</strong></p>           </td>           <td>            <p><strong>Soft</strong></p>            </td>       </tr>       <tr>            <td>            <p><strong>Processing Type:</strong></p>            </td>           <td>            <p><strong>Multiple Extrusion</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Transparency:</strong></p>           </td>           <td>            <p><strong>Transparent</strong></p>         </td>       </tr>       <tr>            <td>            <p><strong>Place of Origin:</strong></p>            </td>           <td>            <p><strong>Shandong, China (Mainland)</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Brand Name:</strong></p>         </td>           <td>            <p><strong>OEM</strong></p>         </td>       </tr>       <tr>            <td>            <p><strong>Width:</strong></p>          </td>           <td>            <p><strong>50mm-1500mm or 2''-60''</strong></p>         </td>       </tr>       <tr>            <td>            <p><strong>Length:</strong></p>         </td>           <td>            <p><strong>By order</strong></p>            </td>       </tr>       <tr>            <td>            <p><strong>Thickness:</strong></p>          </td>           <td>            <p><strong>8mic-50mic or 32-200gauge</strong></p>           </td>       </tr>       <tr>            <td>            <p><strong>Color:</strong></p>          </td>           <td>            <p><strong>Transparent, Black,White Color etc</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Certification:</strong></p>          </td>           <td>            <p><strong>SGS,ISO9001:2008,BV,CTI</strong></p>         </td>       </tr>       <tr>            <td>            <p><strong>Use:</strong></p>            </td>           <td>            <p><strong>Packaging film</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Core:</strong></p>           </td>           <td>            <p><strong>Paper core</strong></p>          </td>       </tr>       <tr>            <td>            <p><strong>Core size:</strong></p>          </td>           <td>            <p><strong>1.5inch,2inch/3inch</strong></p>         </td>       </tr>       <tr>            <td>            <p><strong>Product name:</strong></p>           </td>           <td>            <p><strong>Colored Shrink Wrap Stretch Film(SGS,BV)</strong></p>            </td>       </tr>   </tbody></table><p><img src="https://timg.china.cn/0/1_953_47192_600_600.jpg" /><img src="https://timg.china.cn/0/1_172_47279_597_597.jpg" /><img src="https://timg.china.cn/0/1_222_47177_600_600.jpg" /></p><p><strong>Why Us:</strong></p><p><strong>1, more than 10 years experience in production.</strong></p><p><strong>2, well-known products: Shandong Famous Brand.</strong></p><p><strong>3, Good quality control in production process: Quality Service AAA Grade Credit Enterprise</strong></p><p><strong>4, Excellent quality and Competitive price, OEM is available.</strong></p><p><strong>5, Stable supply: an extensive range of stock.</strong></p><p><strong>6, The whole process from material to end products is under supervision</strong></p><p> </p><p><strong><img src="https://timg.china.cn/0/1_59_47061_600_600.jpg" /><img src="https://timg.china.cn/0/1_118_46968_600_600.jpg" /><img src="https://timg.china.cn/0/1_62_46728_600_600.jpg" /><img src="https://timg.china.cn/0/1_1017_47067_600_600.jpg" /><img src="https://timg.china.cn/0/1_482_46748_600_600.jpg" /></strong></p><p><strong>our business partner</strong></p><p><img src="https://timg.china.cn/0/1_268_47006_600_485.jpg" /></p><p><strong>Our qualification certificate</strong></p><p><img src="https://timg.china.cn/0/1_376_46689_600_437.jpg" /><img src="https://timg.china.cn/0/1_189_46926_600_600.jpg" /></p><p><strong>Our Service:</strong></p><p><strong>1, Your inquiry will be replied within 24 hours and online service is available all the time.</strong></p><p><strong>2, Well-trained & professional sales persons are here ready to answer all your questions and handle the problems.</strong></p><p><strong>3, Prompt delivery time: within 15 days after agreement</strong></p><p><strong>4, Flexible payment terms: T/T, L/C, O/A, Western Union, Paypal, Escrow, etc.</strong></p><p><strong>5, Your business relationship with us will be confidential to any third party.</strong></p><p><strong>6, Good after-sale service offered, please get back if you got question</strong></p><p> </p><p><img src="https://timg.china.cn/0/1_582_47026_600_280.jpg" /><img src="https://timg.china.cn/0/1_224_46767_600_600.jpg" /></p><p><strong>Please contact us</strong></p><p><img src="https://timg.china.cn/0/1_807_52018_600_600.jpg" /></p>
EOT;

    $references = [];
    $affectedNodes = [];
    $document = enterprise_translate_split_html($html, $references, $affectedNodes);
    file_put_contents('src.html', enterprise_translate_dom_get_inner_html($document, $document->getElementsByTagName('body')->item(0)));
    //var_dump($references);
    $srcText = implode('<p>', $references);
    //var_dump($srcText);
    //var_dump($affectedNodes);
    $destText = enterprise_translate_fake_translate($srcText);
    $fragments = explode('<p>', $destText);
    $finalHtml = enterprise_translate_combine_fragments($document, $fragments, $affectedNodes);
    file_put_contents('dest.html', $finalHtml);

    $lenBefore = mb_strlen($html, 'UTF-8');
    $lenAfter = mb_strlen($srcText, 'UTF-8');
    $percentage = ($lenAfter / $lenBefore) * 100;
    $costs = floor($lenAfter / 1000) * 0.02;
    fprintf(STDOUT, "Before=%d, After=%d, Proportion=%.2f%%, Costs=$%.2f" . PHP_EOL, $lenBefore, $lenAfter, $percentage, $costs);

    return EXIT_SUCCESS;
}

exit(main($argc, $argv));