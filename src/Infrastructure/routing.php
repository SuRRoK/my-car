<?php

declare(strict_types=1);

namespace App\Quiz;

use App\Infrastructure\TestController;
use Symfony\Component\Routing\Loader\Configurator\RoutingConfigurator;

return static function (RoutingConfigurator $routes): void {
    $routes->add('test.index', '/test')
        ->controller([TestController::class, 'index'])
        ->methods(['GET'])
        ->options(['expose' => true]);
};
