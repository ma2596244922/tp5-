{if $smarty.get.error_msg|default:''}
                        <div class="alert alert-error">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.error_msg}</span>

                        </div>
{/if}
{if $smarty.get.success_msg|default:''}
                        <div class="alert alert-success">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.success_msg}</span>

                        </div>
{/if}