<?php

declare(strict_types=1);

namespace App\Tests;

use App\Service\PattatrasService;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

final class PattatrasServiceTest extends TestCase
{
    /**
     * @return iterable<array{int, string, string}>
     */
    public static function provideNumbers(): iterable
    {
        yield [1, '1', 'nombre'];
        yield [3, 'Patte', 'patte'];
        yield [5, 'Tatras', 'tatras'];
        yield [15, 'Pattatras', 'pattatras'];
        yield [30, 'Pattatras', 'pattatras'];
        yield [7, '7', 'nombre'];
        yield [6457, '6457', 'nombre'];
    }

    #[DataProvider('provideNumbers')]
    public function testConvert(int $number, string $value, string $type): void
    {
        $service = new PattatrasService();

        self::assertSame($value, $service->convert($number));
        self::assertSame($type, $service->type($number));
    }

    public function testGenerateCoversWholeRange(): void
    {
        $rows = (new PattatrasService())->generate();

        self::assertCount(6457, $rows);
        self::assertSame(['number' => 1, 'value' => '1', 'type' => 'nombre'], $rows[0]);
        self::assertSame(['number' => 6457, 'value' => '6457', 'type' => 'nombre'], $rows[6456]);
    }
}
