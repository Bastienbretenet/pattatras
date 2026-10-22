<?php

declare(strict_types=1);

namespace App\Controller;

use App\Service\PattatrasService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class PattatrasController extends AbstractController
{
    #[Route('/api/pattatras', name: 'api_pattatras', methods: ['GET'])]
    public function list(PattatrasService $pattatras): JsonResponse
    {
        return $this->json($pattatras->generate());
    }

    #[Route('/api/pattatras/{number}', name: 'api_pattatras_number', requirements: ['number' => '\d+'], methods: ['GET'])]
    public function convert(int $number, PattatrasService $pattatras): JsonResponse
    {
        if ($number < PattatrasService::MIN || $number > PattatrasService::MAX) {
            return $this->json(
                ['error' => \sprintf('Le nombre doit être compris entre %d et %d.', PattatrasService::MIN, PattatrasService::MAX)],
                Response::HTTP_UNPROCESSABLE_ENTITY,
            );
        }

        return $this->json($pattatras->result($number));
    }
}
