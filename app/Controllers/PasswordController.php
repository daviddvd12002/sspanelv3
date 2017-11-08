<?php

namespace App\Controllers;

use App\Models\PasswordReset;
use App\Models\User;
use App\Services\Password;
use App\Utils\Hash;

/***
 * Class Password
 * @package App\Controllers
 * 密码重置
 */
class PasswordController extends BaseController
{
    public function reset()
    {
        return $this->view()->display('password/reset.tpl');
    }

    public function handleReset($request, $response, $args)
    {
        $email = $request->getParam('email');
        // check limit

        // send email
        $user = User::where('email', $email)->first();
        if ($user == null) {
            $rs['ret'] = 0;
            $rs['msg'] = 'Invalid e-mail address.';
            return $response->getBody()->write(json_encode($rs));
        }
        Password::sendResetEmail($email);
        $rs['ret'] = 1;
        $rs['msg'] = 'Sent, please check your e-mail.';
        return $response->getBody()->write(json_encode($rs));
    }

    public function token($request, $response, $args)
    {
        $token = $args['token'];
        return $this->view()->assign('token', $token)->display('password/token.tpl');
    }

    public function handleToken($request, $response, $args)
    {
        $tokenStr = $args['token'];
        $password = $request->getParam('password');
        // check token
        $token = PasswordReset::where('token', $tokenStr)->first();
        if ($token == null || $token->expire_time < time()) {
            $rs['ret'] = 0;
            $rs['msg'] = 'The link has expired, please retrieve it again.';
            return $response->getBody()->write(json_encode($rs));
        }

        $user = User::where('email', $token->email)->first();
        if ($user == null) {
            $rs['ret'] = 0;
            $rs['msg'] = 'The link has expired, please retrieve it again.';
            return $response->getBody()->write(json_encode($rs));
        }

        // reset password
        $hashPassword = Hash::passwordHash($password);
        $user->pass = $hashPassword;
        if (!$user->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = 'Reset failed, please try again';
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = 'Success';
        return $response->getBody()->write(json_encode($rs));
    }
}
