/* eslint no-alert: 'off' */
/*global $ */
$(function () {
    'use strict';
    $('.js-publication-switch').each(function () {
        $(this).on('change', function () {
            var attribute = $(this).attr('data-attribute'),
                target = $(this).attr('data-target'),
                state = $(this).is(':checked'),
                data = {};

            data[attribute] = state;

            $.ajax(target, { method: 'PUT', data: data })
                .fail(function () {
                    window.alert('An error occured');
                });
        });
    });
});
