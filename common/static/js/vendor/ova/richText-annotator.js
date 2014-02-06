/* 
Rich Text Annotator Plugin v1.0 (https://github.com/danielcebrian/richText-annotator)
Copyright (C) 2014 Daniel Cebrián Robles
License: https://github.com/danielcebrian/richText-annotator/blob/master/License.rst

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
var _ref,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Annotator.Plugin.RichText = (function(_super) {
	__extends(RichText, _super);
	
	
	//Default tinymce configuration
	RichText.prototype.options = {
		tinymce:{
			selector: "li.annotator-item textarea",
			plugins: "media image insertdatetime link code",
			menubar: false,
			toolbar_items_size: 'small',
			extended_valid_elements : "iframe[src|frameborder|style|scrolling|class|width|height|name|align|id]",
    		toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media rubric | code ",
		}
	};

	function RichText(element,options) {
		_ref = RichText.__super__.constructor.apply(this, arguments);
		return _ref;
	};


	RichText.prototype.pluginInit = function() {
		var annotator = this.annotator,
			editor = this.annotator.editor;
		//Check that annotator is working
		if (!Annotator.supported()) {
			return;
		}
		
		//Editor Setup
		annotator.editor.addField({
			type: 'input',
			load: this.updateEditor,
		});
		
		//Viewer setup
		annotator.viewer.addField({
			load: this.updateViewer,
		});
		
		
		annotator.subscribe("annotationEditorShown", function(){
			$(annotator.editor.element).find('.mce-tinymce')[0].style.display='block';
			$(annotator.editor.element).find('.mce-container').css('z-index',3000000000);
			annotator.editor.checkOrientation();
		});
		annotator.subscribe("annotationEditorHidden", function(){
			$(annotator.editor.element).find('.mce-tinymce')[0].style.display='none';
		});
		
		//set listener for tinymce;
		this.options.tinymce.setup = function(ed) {
			ed.on('change', function(e) {
				//set the modification in the textarea of annotator
				$(editor.element).find('textarea')[0].value = tinymce.activeEditor.getContent();
			});
			ed.on('Init', function(ed){
				$('.mce-container').css('z-index','3090000000000000000');
			});
			//New button to add Rubrics of the url https://gteavirtual.org/rubric
		    ed.addButton('rubric', {
		        icon: 'rubric',
		        title : 'Insert a rubric',
		        onclick: function() {
		        	ed.windowManager.open({
				        title: 'Insert a public rubric of the webside https://gteavirtual.org/rubric   ',
				        body: [
				            {type: 'textbox', name: 'url', label: 'Url'}
				        ],
				        onsubmit: function(e) {
				            // Insert content when the window form is submitted
				            var url = e.data.url,
				            	name = 'irb',
				            	irb;
				            //get the variable 'name' from the given url
							name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
							var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
								results = regex.exec(url);
								
							//the rubric id
							irb = results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
							if (irb==''){
								ed.windowManager.alert('Error: The given webpage didn\'t have a irb variable in the url');
							}else{
								var iframeRubric = "<iframe src='https://gteavirtual.org/rubric/?mod=portal&scr=viewrb&evt=frame&irb="+irb+"' style='width:800px;height:600px;overflow-y: scroll;background:transparent' frameborder='0' ></iframe>";
								ed.setContent(ed.getContent()+iframeRubric);
								$(editor.element).find('textarea')[0].value = ed.getContent();
							}
				        }
				    });
		            ed.insertContent('Main button');
		            ed.label = 'My Button';
		        }
		    });
		};
		tinymce.init(this.options.tinymce);
	};
	
	RichText.prototype.updateEditor = function(field, annotation) {
		var text = typeof annotation.text!='undefined'?annotation.text:'';
		tinymce.activeEditor.setContent(text); 
		$(field).remove(); //this is the auto create field by annotator and it is not necessary
	}
	
	RichText.prototype.updateViewer = function(field, annotation) {
		var textDiv = $(field.parentNode).find('div:first-of-type')[0];
		textDiv.innerHTML =annotation.text;
		$(textDiv).addClass('richText-annotation');
		$(field).remove(); //this is the auto create field by annotator and it is not necessary
	}
	
	return RichText;

})(Annotator.Plugin);

