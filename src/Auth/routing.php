<?php

declare(strict_types=1);

namespace App\Auth;

use Symfony\Component\Routing\Loader\Configurator\RoutingConfigurator;

return static function (RoutingConfigurator $routes): void {
    $routes
        ->add('app_login', '/login')
        ->controller([SecurityController::class, 'login']);

    $routes
        ->add('app_logout', '/logout')
        ->controller([SecurityController::class, 'logout']);
};
