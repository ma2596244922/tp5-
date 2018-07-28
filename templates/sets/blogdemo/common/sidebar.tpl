        <div class="rside fr">
<!-- Search Form
<div class="blog_search clean">
    <form action="/blog/" method="get">
        <input class="fl btn" type="submit" value="" />
        <input class="fl text" name="Keyword" type="text" placeholder="Search tutorials and articles..." />
        <input type="hidden" name="p" value="list" />
    </form>
</div>
-->
<div class="stick">
    <div class="clean"><div class="title">Categories</div></div>
    <div class="ct">
        <ul class="stlist">
{foreach $groups as $group}
            <li>&bull; <a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a></li>
{/foreach}
        </ul>
    </div>
</div>
        </div>