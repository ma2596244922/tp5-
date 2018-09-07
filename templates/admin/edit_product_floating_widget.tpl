                    <!-- BEGIN TODO DROPDOWN -->
{literal}
                    <li class="dropdown open" id="product-indicators">

                        <a href="#" class="dropdown-toggle">

                            <i class="icon-tasks"></i>

                            <span class="badge">{{ badges }}</span>

                        </a>

                        <ul class="dropdown-menu extended tasks" style="right: inherit;">

                            <li>

                                <p>内容完整度{{ integrityPercentage }}%</p>

                            </li>

                            <indicator-item v-for="(indicator, name) in indicators"
                                    :key="name"
                                    v-bind:label="indicator.label"
                                    v-bind:percentage="indicator.percentage"
                                    v-bind:attr_class="indicator.attr_class"></indicator-item>

                            <li class="external">

                                <a href="#">标记 * 为必填项</a>

                            </li>

                        </ul>

                    </li>
{/literal}
                    <!-- END TODO DROPDOWN -->
