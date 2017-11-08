{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Node List
            <small>Node List</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>How to use</h4>
                    <p>--------- </p>
                    {$msg}
                </div>
            </div>
        </div>

        {foreach $nodes as $node}
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-widget">
                        <div class="box-body">
                            <ul class="products-list product-list-in-box">
                                <li class="item">
                                    <div class="product-img">
                                        <img src="../assets/public/img/iconfont-server.png" alt="Server Node">
                                    </div>
                                    <div class="product-info">
                                        <a href="./node/{$node->id}" class="product-title">{$node->name} <span
                                                    class="label label-info pull-right">{$node->status}</span></a>
                                        <p>
                                            {$node->info}
                                        </p>
                                    </div>
                                </li><!-- /.item -->
                            </ul>
                        </div>
                        <div class="box-footer no-padding">
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="nav nav-stacked">
                                        <li><a href="./node/{$node->id}">Address <span
                                                        class="pull-right badge bg-green">{$node->server}</span></a></li>
                                        <li><a href="./node/{$node->id}">Port <span
                                                        class="pull-right badge bg-green">443</span></a></li>
                                        <li><a href="./node/{$node->id}">Method <span
                                                        class="pull-right badge bg-green">{if $node->custom_method == 1} {$user->method} {else} {$node->method} {/if}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Password(public) <span
                                                        class="pull-right badge bg-green">pubpassword</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Protocal: <span
                                                        class="pull-right badge bg-green">{$user->protocol}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Protocal parameter: <span
                                                        class="pull-right badge bg-green">{$user->port}:{$user->passwd}</span></a>
                                        </li>
                                         <li><a href="./node/{$node->id}">Obfuscation: <span
                                                        class="pull-right badge bg-green">tls1.2_ticket_auth</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Obfuscation parameter (optional): <span
                                                        class="pull-right badge bg-green">bing.com</span></a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="nav nav-stacked">

                                        <li><a href="./node/{$node->id}">Ratio <span 
                                                        class="pull-right badge bg-blue">{$node->traffic_rate}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">online users <span
                                                        class="pull-right badge bg-blue">{$node->getOnlineUserCount()}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Traffic <span
                                                        class="pull-right badge bg-blue">{$node->getTrafficFromLogs()}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Uptime: <span
                                                        class="pull-right badge bg-blue">{$node->getNodeUptime()}</span></a>
                                        </li>
                                        <li><a href="./node/{$node->id}">Loading: <span
                                                        class="pull-right badge bg-blue">{$node->getNodeLoad()}</span></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div><!-- /.widget-user -->
                </div><!-- /.col -->
            </div>
            <!-- /.row -->


        {/foreach}
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->


{include file='user/footer.tpl'}
