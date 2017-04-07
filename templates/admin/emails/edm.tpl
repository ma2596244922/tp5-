<p><strong>Dear Sir or Madam:</strong></p>

<p>Have a good day!</p>

<p>We got to know that you are interested in {$selected_groups[0].name}.</p>

<p>We are a professional manufacturer of&nbsp;{$selected_groups[0].name}&nbsp;and&nbsp;{$selected_groups[1].name}&nbsp;in China. Here I recommend some of our most popular products as following:</p>

<table border="0" cellpadding="0" cellspacing="0">
    <tbody>
{foreach $selected_groups as $i => $group}
        <tr>
            <td colspan="6"><strong><a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a></strong></td>
        </tr>
        <tr>
    {-foreach $product_array[$i] as $product}
            <td>
            <p><img alt="{$product.caption|escape}" src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'m'}" style="height:100px; width:100px" /></p>
            </td>
            <td>
            <p>{$product.caption|escape}</p>
            </td>
    {-/foreach}
        </tr>
{/foreach}
    </tbody>
</table>

<p>If you want to know more information about our company and products, please browse our website at&nbsp;<strong><a href="http://{$site_root_domain}/">http://{$site_root_domain}/</a></strong>. We will offer competitive price and trustable quality for you.</p>

<p>Hope to cooperate with you.</p>

<p>Warm regards,</p>

<p><strong>{$contacts[0].name}</strong></p>

<p><strong>{$corporation.name}</strong><br />
{$corporation.address}<br />
Tel: {$corporation.tel_wt}<br />
Fax: {$corporation.fax}<br />
Web:&nbsp;<a href="http://{$site_root_domain}/?edm_pic_site">http://{$site_root_domain}/</a></p>
