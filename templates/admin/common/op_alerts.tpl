{if $smarty.get.error_msg|default:'' || $error_msg|default:''}
                        <div class="alert alert-error">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.error_msg|default:''}{$error_msg|default:''}</span>

                        </div>
{/if}
{if $smarty.get.success_msg|default:'' || $success_msg|default:''}
                        <div class="alert alert-success">

                            <button class="close" data-dismiss="alert"></button>

                            <span>{$smarty.get.success_msg|default:''}{$success_msg|default:''}</span>

                        </div>
{/if}