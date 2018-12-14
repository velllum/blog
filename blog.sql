-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 13 2018 г., 23:36
-- Версия сервера: 10.1.35-MariaDB
-- Версия PHP: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `blog`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `title`, `slug`, `created_at`, `updated_at`) VALUES
(16, 'molestias', 'molestias', '2018-11-05 15:59:25', '2018-11-05 15:59:25'),
(17, 'commodi', 'commodi', '2018-11-05 16:00:06', '2018-11-05 16:00:06'),
(18, 'rerum', 'rerum', '2018-11-05 16:00:06', '2018-11-05 16:00:06'),
(19, 'unde', 'unde', '2018-11-05 16:00:06', '2018-11-05 16:00:06');

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '2018_09_23_184922_create_caregories_table', 2),
(18, '2014_10_12_000000_create_users_table', 3),
(19, '2014_10_12_100000_create_password_resets_table', 3),
(20, '2018_09_23_191330_create_categories_table', 3),
(21, '2018_09_23_191750_create_tags_table', 3),
(22, '2018_09_23_192028_create_comments_table', 3),
(23, '2018_09_23_192058_create_posts_table', 3),
(24, '2018_09_23_192142_create_subscriptions_table', 3),
(25, '2018_09_23_194159_create_posts_tags_table', 3),
(26, '2018_10_04_110155_add_avatar_column_to_users', 4),
(27, '2018_10_05_133724_make_password_nullable', 5),
(28, '2018_10_11_163744_add_date_to_post', 6),
(29, '2018_10_12_173401_add_image_to_post', 7),
(30, '2018_11_05_193219_add_description_to_posts', 8);

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `categories_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `is_featured` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `content`, `categories_id`, `user_id`, `views`, `status`, `is_featured`, `created_at`, `updated_at`, `date`, `image`, `description`) VALUES
(2, 'Eaque expedita eligendi ut recusandae.', 'eaque-expedita-eligendi-ut-recusandae', '<p>A vel blanditiis rerum quos debitis.</p>', NULL, 1, 4268, 0, 1, '2018-11-05 16:08:25', '2018-11-05 17:10:31', '2018-05-10', 'photo1.png', '<p>dfsdfsdfsdfsdfsdfsdfsdfsd</p>'),
(3, 'In eos omnis neque corrupti eaque ut.', 'in-eos-omnis-neque-corrupti-eaque-ut', '<p>Porro et perspiciatis et ut molestiae.</p>', 16, 1, 518, 0, 0, '2018-11-05 16:08:26', '2018-11-05 17:10:52', '2018-05-10', 'photo1.png', '<p>gjykyukuiku trhtrhtrhtrh rthtrhtrhtrh</p>'),
(4, 'Facilis sapiente commodi et dolores laboriosam.', 'facilis-sapiente-commodi-et-dolores-laboriosam', '<p>Minus dolorem sed aut tenetur voluptatum at repudiandae.</p>', 19, 1, 3114, 0, 1, '2018-11-05 16:08:26', '2018-11-05 17:11:37', '2018-05-10', 'photo1.png', '<p>hrttrhrthtrh dvergergergerger&nbsp;</p>'),
(5, 'Neque rerum culpa recusandae.', 'neque-rerum-culpa-recusandae', '<p>Et ipsa iste culpa in et et accusantium.</p>', 18, 1, 4605, 0, 1, '2018-11-05 16:08:26', '2018-11-05 17:12:09', '2018-05-10', 'photo1.png', '<p><strong>dfvdfvdfvdfvdfv dfvdfvdfvdf</strong></p>'),
(6, 'Ad enim quia rerum tempora quia.', 'ad-enim-quia-rerum-tempora-quia', '<p>Sequi molestiae eum iusto id enim consequatur.</p>', 18, 1, 998, 0, 1, '2018-11-05 16:08:26', '2018-11-12 16:28:54', '2018-05-10', 'photo1.png', '<p><strong>osdjfosjdcojsdoj jsdcoisjdocij</strong></p>');

-- --------------------------------------------------------

--
-- Структура таблицы `post_tags`
--

CREATE TABLE `post_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `post_tags`
--

INSERT INTO `post_tags` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(14, 2, 8, NULL, NULL),
(15, 2, 9, NULL, NULL),
(16, 3, 8, NULL, NULL),
(17, 3, 9, NULL, NULL),
(18, 3, 11, NULL, NULL),
(19, 4, 8, NULL, NULL),
(20, 4, 9, NULL, NULL),
(21, 4, 11, NULL, NULL),
(22, 5, 8, NULL, NULL),
(23, 5, 9, NULL, NULL),
(24, 5, 10, NULL, NULL),
(25, 6, 7, NULL, NULL),
(26, 6, 8, NULL, NULL),
(27, 6, 9, NULL, NULL),
(28, 6, 10, NULL, NULL),
(29, 6, 11, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tags`
--

INSERT INTO `tags` (`id`, `title`, `slug`, `created_at`, `updated_at`) VALUES
(7, 'vero', 'vero', '2018-11-05 16:01:22', '2018-11-05 16:01:22'),
(8, 'repudiandae', 'repudiandae', '2018-11-05 16:01:22', '2018-11-05 16:01:22'),
(9, 'eaque', 'eaque', '2018-11-05 16:01:22', '2018-11-05 16:01:22'),
(10, 'sit', 'sit', '2018-11-05 16:01:22', '2018-11-05 16:01:22'),
(11, 'excepturi', 'excepturi', '2018-11-05 16:01:22', '2018-11-05 16:01:22');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_admin` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `is_admin`, `status`, `remember_token`, `created_at`, `updated_at`, `avatar`) VALUES
(3, 'Pavel', 'vasya@ya.ru', '$2y$10$P8Vlvb4Q8Z.SmgQ.Ia48euKRTdl2wC1FIFpwMcTJqDGiLy7HACqOe', 0, 0, 'vI17tkOzeraA3LujEZq0d7ktlnKtK8AgcV4K09ELyKqo49owlV8PD5uId82k', '2018-11-21 17:41:17', '2018-11-21 17:41:17', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
