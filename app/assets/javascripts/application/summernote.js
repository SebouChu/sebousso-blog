/*global $ */
$(function () {
    'use strict';

    $('[data-provider="summernote"]').each(function () {
        $(this).summernote({
            disableDragAndDrop: true,
            inheritPlaceholder: true,
            followingToolbar: true,
            toolbar: [
                ['headline', ['style']],
                ['style', ['bold', 'italic']],
                ['font', ['superscript', 'subscript']],
                ['alignment', ['ul', 'ol', 'paragraph']],
                ['insert', ['hr']],
                ['link', ['linkDialogShow', 'unlink']],
                ['code', ['codeview']]
            ],
            styleTags: ['p', 'blockquote', 'pre', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'],
            callbacks: {
                onImageUpload: function () {
                    // Prevent upload
                },
                onPaste: function (event) {
                    // Remove text styles on paste
                    var paragraph = document.createElement('p');
                    event.preventDefault();
                    // Get and trim clipboard content as paragraph
                    paragraph.textContent = ((event.originalEvent || event).clipboardData || window.clipboardData).getData('Text').trim();
                    // Delete selection if anything is selected (expected behaviour on paste)
                    if ((typeof window.getSelection !== 'undefined' ? window.getSelection() : document.selection.createRange()).toString().length > 0) {
                        document.execCommand('delete', false);
                    }
                    // Insert trimmed clipboard content as paragraph
                    document.execCommand('insertHTML', false, paragraph.outerHTML);
                },
                onInit: function () {
                    $(this).summernote('removeModule', 'autoLink');
                }
            }
        });
    });
});
