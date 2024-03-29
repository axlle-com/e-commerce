<?php

use App\Common\Models\Blog\PostCategory;

/**
 * @var $title string
 * @var $template string
 * @var $model PostCategory
 */

$posts = $model->posts ?? [];
$array = [
    [
        'title' => 'Семья Блиновых',
        'text' => 'От лица всей нашей семьи Блиновых, выражаем особую благодарность, замечательному и профессиональному адвокату Соколову Якову Александровичу. Яков Александрович, после пяти других адвокатов, взялся за наше уголовное дело ст. 105 ч. 1 УК РФ. Несмотря на свой молодой возраст, он грамотно отстаивал и защищал наши интересы. На протяжении года, пока велось следствие, пять адвокатов нам не смогли помочь. После чего Яков Александрович добился того, чтобы ни в чем неповинного человека отпустили. Хотелось бы, чтобы было побольше таких честных, умных, квалифицированных адвокатов, которые относятся к чужой проблеме с душой. Главный показатель  хорошего адвоката, это выигранное дело. Так все начиналось - репортаж «Жертва обстоятельств» <a href="https://6tv.ru/238891421164320" target="_blank">https://6tv.ru/238891421164320.</a>'
    ],
    [
        'title' => 'Наталья',
        'text' => 'Благодарю Якова Александровича за консультацию в сложном уголовном деле. Благодаря нужным советам и рекомендациям получилось сдвинуть дело с мертвой точки.'
    ],
    [
        'title' => 'Никита',
        'text' => 'Решили воспользоваться помощью именно Якова Александровича, так как он смог оперативно подключиться и в кротчайшие сроки приступить к работе. Опыт адвоката имел существенный вес при принятии решения. Обратились за защитой интересов в рамках уголовного дела по ст. 318 УК РФ. Яков Александрович профессионально исполнял свои обязанности адвоката. В ходе работы по уголовному делу проявлена высокая степень вовлеченности, индивидуальный подход к решению проблем клиента. Получили результат, превышающий ожидания - уголовное дело прекращено - суд определил минимальное наказание в виде судебного штрафа.'
    ],
    [
        'title' => 'Владимир',
        'text' => 'В работе Якова Александровича увидел наличие профессиональных навыков и внимание к личной проблеме. Мне понравилась быстрая реакция на проблему и молчание, ничего лишнего. Но когда надо, реагирует быстро, вежливо и жестко.'
    ],
];
$array2 = [
    [
        'title' => 'Виталий<br>(Генеральный директор, ООО ХОРЕКА)',
        'text' => 'Необычная и очень интересная тема для конференции. Ведь никто не застрахован от того, что исполнительные органы власти, делая свою работу, могут прийти с проверками и в обычную коммерческую фирму. Зная, как кажется, все нюансы взаимодействия с клиентами, поставщиками, партнёрами и заказчиками, упускаешь из вида, что совершенно не знаешь, как вести себя с полицейским и следователями. Именно такой тренинг позволяет морально и юридически быть готовым к любым ситуациям. Хотел получить ответы на вопросы «зачем приходят?», «как себя вести?», «что делать, когда уходят?». И на все эти вопросы я получил развёрнутые ответы.',
    ],
    [
        'title' => 'Екатерина Висторова<br>(Менеджер, МОБО «Национальный центр социальной помощи»)',
        'text' => 'Тренинг был интересен и полезен. Никогда не знаешь, когда и по какой причине столкнешься с той или иной ситуацией. Спасибо большое, за очень подробное и понятное объяснение всех тонкостей, моментов на которые стоит обратить внимание, что стоит озвучивать сразу, а что потом.',
    ],
    [
        'title' => 'Марина',
        'text' => 'Лекция была информативной и при этом лаконичной, с примерами из реальной практики. Было полезно и интересно узнать, как вести себя в разных ситуациях при взаимодействии с силовыми органами.',
    ],
    [
        'title' => 'Дмитрий Кацуба<br>(Генеральный директор, Free Brand LLC)',
        'text' => 'Мне были интересны все нюансы от поведения при обыске, до поведения на допросе. О чем лучше молчать, а на что обратить внимание. Определенные плюсы, это хорошо построенное повествование лектора, понятное разъяснение возникающих вопросов и живой разбор на конкретных примерах.',
    ],
    [
        'title' => 'Анна<br>(Бухгалтер)',
        'text' => 'Интересно было всё. Рассказывали понятным доступным языком. Полезно узнать о том, как вести себя на обыске и при допросе, узнать свои права, возможности действий, как правильно наблюдать за процессом, на что обратить внимание. Узнала много нового (точнее, всё).',
    ],
];
?>
@extends($template.'layout',['title' => $title ?? ''])
@section('content')
    <div id="service" class="tokyo_tm_section active animated fadeInLeft">
        <div class="container">
            <div class="tokyo_tm_services">
                <div class="tokyo_tm_title">
                    <div class="title_flex">
                        <div class="left">
                            <span>Услуги</span>
                            <h3><?= $title ?></h3>
                        </div>
                    </div>
                </div>
                <div class="list">
                    <ul>
                        <?php $cnt = 1 ?>
                        <?php foreach($posts as $post){ ?>
                        <li>
                            <div class="list_inner dark">
                                <span class="number"><?= $cnt ?></span>
                                <h3 class="title"><?= $post['title'] ?></h3>
                                <p class="text"><?= $post['preview_description'] ?? $post['description'] ?></p>
                                <div class="tokyo_tm_read_more">
                                    <a href="#"><span>Читать</span></a>
                                </div>
                                <a class="tokyo_tm_full_link" href="#"></a>
                                <!-- Service Popup Start -->
                                <div class="service_hidden_details">
                                    <div class="service_popup_informations">
                                        <div class="descriptions">
                                                <?= $post['description'] ?>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </li>
                            <?php $cnt++ ?>
                        <?php } ?>
                    </ul>
                </div>
            </div>
        </div>
        <?php if(1){ ?>
        <div class="tokyo_tm_testimonials dark">
            <div class="container">
                <div class="tokyo_section_title">
                    <h3>Отзывы о защите</h3>
                </div>
                <div class="list">
                    <ul class="owl-carousel">
                            <?php foreach($array as $item){ ?>
                        <li>
                            <div class="list_inner">
                                <div class="text">
                                    <div class="js-text">
                                            <?= $item['text'] ?>
                                    </div>
                                </div>
                                <div class="details">
                                    <div class="info">
                                        <h3><?= $item['title'] ?></h3>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <?php } ?>
                    </ul>
                </div>
            </div>
        </div>
        <?php } ?>
        <?php if(1){ ?>
        <div class="tokyo_tm_testimonials grey">
            <div class="container">
                <div class="tokyo_section_title">
                    <h3>Отзывы о тренингах</h3>
                </div>
                <div class="list">
                    <ul class="owl-carousel">
                            <?php foreach($array2 as $item){ ?>
                        <li>
                            <div class="list_inner">
                                <div class="text">
                                    <div class="js-text">
                                            <?= $item['text'] ?>
                                    </div>
                                </div>
                                <div class="details">
                                    <div class="info">
                                        <h3><?= $item['title'] ?></h3>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <?php } ?>
                    </ul>
                </div>
            </div>
        </div>
        <?php } ?>
    </div>
@endsection
