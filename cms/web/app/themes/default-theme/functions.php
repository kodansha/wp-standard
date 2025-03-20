<?php

/**
 * カスタム投稿タイプのサンプル
 */
add_action('init', function () {
    $labels = [
        'name' => __('ニュース'),
        'add_new' => '新規ニュース追加',
        'add_new_item' => '新規ニュースを追加',
        'edit_item' => 'ニュースを編集',
        'new_item' => '新規ニュース',
        'view_item' => 'ニュースを表示',
        'search_items' => 'ニュースを検索',
    ];

    register_post_type(
        'news',
        [
            'labels' => $labels,
            'public' => true,
            'show_ui' => true,
            'menu_position' => 5,
            'supports' => ['title', 'thumbnail', 'editor'],
            'show_in_rest' => true,
        ],
    );

    register_taxonomy(
        'news-cat',
        'news',
        [
            'label' => 'ニュースカテゴリー',
            'hierarchical' => true,
            'public' => true,
            'show_in_rest' => true,
        ],
    );
});
