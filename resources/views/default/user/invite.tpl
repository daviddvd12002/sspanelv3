{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Invite
            <small>Invite</small>
        </h1>
    </section>

    <!-- Main content --><!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-sm-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> ERROR!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-rocket"></i>

                        <h3 class="box-title">Invite</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p>You can generate <code>{$user->invite_num}</code> invitation code。 </p>
                        {if $user->invite_num }
                        <div class="input-group">
                            <input class="form-control" id="num" type="number" placeholder="How many codes? ">
                            <div class="input-group-btn">
                                <button id="invite" class="btn btn-info">Generate my invitation code</button>
                            </div>
                        </div>
                        {/if}
                    </div>
                    <!-- /.box -->
                    <div class="box-header">
                        <h3 class="box-title">My invitation code</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>###</th>
                                <th>Invitation Code(Right click to copy link)</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $codes as $code}
                                <tr>
                                    <td><b>{$code->id}</b></td>
                                    <td><a href="/auth/register?code={$code->code}" target="_blank">{$code->code}</a>
                                    </td>
                                    <td>Available</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-6">

                <div class="callout callout-info">
                    <h4>About</h4>

                    <p>You can generate invitation code 48 hours after registration. </p>

                    <p>You can share invitation code to your friend. </p>

                </div>
            </div>
            <!-- /.col (right) -->
        </div>
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                data: {
                    num: $("#num").val()
                },
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    alert("ERROR：" + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
