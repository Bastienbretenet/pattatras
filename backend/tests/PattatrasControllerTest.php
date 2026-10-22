<?php

declare(strict_types=1);

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class PattatrasControllerTest extends WebTestCase
{
    public function testApiReturnsWholeSequence(): void
    {
        $client = self::createClient();
        $client->request('GET', '/api/pattatras');

        self::assertResponseIsSuccessful();

        $rows = json_decode((string) $client->getResponse()->getContent(), true);
        self::assertCount(6457, $rows);
        self::assertSame(['number' => 15, 'value' => 'Pattatras', 'type' => 'pattatras'], $rows[14]);
    }

    public function testApiConvertsOneNumber(): void
    {
        $client = self::createClient();
        $client->request('GET', '/api/pattatras/15');

        self::assertResponseIsSuccessful();
        self::assertSame(
            ['number' => 15, 'value' => 'Pattatras', 'type' => 'pattatras'],
            json_decode((string) $client->getResponse()->getContent(), true),
        );
    }

    public function testApiRejectsOutOfRangeNumber(): void
    {
        $client = self::createClient();
        $client->request('GET', '/api/pattatras/6458');

        self::assertResponseStatusCodeSame(422);
    }
}
