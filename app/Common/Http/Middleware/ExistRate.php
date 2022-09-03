<?php

namespace App\Common\Http\Middleware;

use Closure;
use App\Common\Models\Wallet\Currency;
use App\Common\Http\Controllers\AppController;
use Illuminate\Auth\Middleware\Authenticate as Middleware;

class ExistRate extends Middleware
{
    public function handle($request, Closure $next, ...$guards)
    {
        $rate = Currency::checkExistRate();
        $controller = new AppController($request);
        if ($rate) {
            return $next($request);
        }
        return $controller->badRequest()->error(message: 'Not found currency rate');
    }
}
