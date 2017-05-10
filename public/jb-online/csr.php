<?php
/**
 * 创建证书申请
 *
 * @package timandes\enterprise
 */

require_once realpath(__DIR__ . '/../../') . '/bootstrap.php';

$configargs = array(
        'private_key_type' => OPENSSL_KEYTYPE_RSA,
        'private_key_bits' => 2048,
    );
$dn = array(
        "countryName" => "CN",
        "stateOrProvinceName" => "Beijing",
        "localityName" => "Beijing",
        "organizationName" => "Zhang Lei",
        //"organizationalUnitName" => "",
        //"emailAddress" => "",
    );

$domain = timandes_get_query_data('domain');
$dn['commonName'] = $domain;

$pkey = openssl_pkey_new($configargs);

$csr = openssl_csr_new($dn, $pkey, $configargs);

openssl_pkey_export($pkey, $pkeyout);
openssl_csr_export($csr, $csrout);

?>
<p>Domain: <?php echo $domain; ?></p>
<p>Key:</p>
<textarea rows="15" cols="80" readonly><?php echo $pkeyout;?></textarea>
<p>CSR:</p>
<textarea rows="15" cols="80" readonly><?php echo $csrout;?></textarea>