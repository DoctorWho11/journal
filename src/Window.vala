/* Copyright 2014 Ryan Sipes
*
* This file is part of Evolve Journal.
*
* Evolve Journal is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Evolve Journal is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Evolve Journal. If not, see http://www.gnu.org/licenses/.
*/

using Gtk;

namespace EvolveJournal {

  public string buffer;

  public class EvolveWindow : Window {

    public Gtk.Window MainWindow (EvolveJournal.EvolveNotebook notebook) {

    this.window_position = WindowPosition.CENTER;
    set_default_size (600, 400);

    var headbar = new HeaderBar();
    headbar.set_title("Journal");
    headbar.set_show_close_button(true);
    this.set_titlebar(headbar);

    headbar.show();

    notebook.show();

    var open_button = new Button.from_icon_name("emblem-documents-symbolic", IconSize.SMALL_TOOLBAR);
    headbar.add (open_button);
    open_button.show();
    open_button.clicked.connect (() => {
      var file = new EvolveJournal.Files();
      buffer = file.on_open_clicked();
      notebook.new_tab(buffer);
      });

    var share_button = new Button.from_icon_name("emblem-shared-symbolic", IconSize.SMALL_TOOLBAR);
    headbar.add (share_button);
    share_button.show();
    share_button.clicked.connect (() => {

      int current_tab = notebook.get_current_page();
      stdout.printf(current_tab.to_string() +"\n");
      string typed_text = notebook.get_text();
      var share = new EvolveJournal.Share();
      share.generate_paste(typed_text, true, "Evolve Test", "10M", "vala", this);

    });

    var save_button = new Button.from_icon_name("document-save-symbolic", IconSize.SMALL_TOOLBAR);
    headbar.add (save_button);
    save_button.show();
    save_button.clicked.connect (() => {
      string typed_text = notebook.get_text();
      stdout.printf(typed_text + "\n");
      });

    var vbox = new Box (Orientation.VERTICAL, 0);

    vbox.pack_start(headbar, false, true, 0);
    vbox.pack_start(notebook, true, true, 0);
    vbox.show();
    this.add (vbox);

    headbar.show_all();

    return this;
    }
  }
}