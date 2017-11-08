{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Traffic Log
            <small>Traffic Log</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="callout callout-warning">
                    <h4>Traffic Log</h4>
                    <p>Some nodes do not support traffic recording.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box form-inline">
                     <div class="form-group">
                        <label for="labelNode">Node</label>
                        <select id="search-node">
                            <option value="0">All</option>
                        {foreach $nodes as $node}
                            <option value="{$node->id}" {if $node->id==$seleNode}selected="selected"{/if}>
                                {$node->name}
                            </option>  
                        {/foreach}
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary" id="log-search">Search</button>
                </div>
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$logs->render()}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>Node</th>
                                <th>Magnification</th>
                                <th>The actual use of traffic</th>
                                <th>Recording traffic</th>
                                <th>Record time</th>
                            </tr>
                            {foreach $logs as $log}
                                <tr>
                                    <td>#{$log->id}</td>
                                    <td>{$log->node()->name}</td>
                                    <td>{$log->rate}</td>
                                    <td>{$log->totalUsed()}</td>
                                    <td>{$log->traffic}</td>
                                    <td>{$log->logTime()}</td>
                                </tr>
                            {/foreach}
                        </table>
                        {$logs->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<script>
    $(document).ready(function () {
        $("#log-search").click(function () {
            window.setTimeout("location.href='/user/trafficlog/"+$("#search-node").val()+"'", 500);
        })
    })
</script>

{include file='user/footer.tpl'}
