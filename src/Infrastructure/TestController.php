<?php

declare(strict_types=1);

namespace App\Infrastructure;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

final class TestController extends AbstractController
{
    public function index(Request $request): Response
    {
        return $this->render('test/index.html.twig');
    }
}
