defmodule Phoenix.LiveEditable do
  import Phoenix.LiveView
  import Phoenix.HTML

  # alias Phoenix.LiveEditable

  # ----- view helpers -----
  
  def live_edit(assigns, label, opts) do
    IO.inspect opts, label: "LiveEdit OPTS"
    Keyword.has_key?(opts, :id) || raise("Needs `:id` option")
    Keyword.has_key?(opts, :type) || raise("Needs `:type` option ('text' | 'select')")
    optid = opts[:id]
    focus = assigns[:focus]
    target = if opts[:target], do: "phx-target='#{opts[:target]}'", else: ""

    if optid == focus do

      module = css_framework_module()

      case opts[:type] do
        "text" -> module.form_text(label, opts)
        "select" -> module.form_select(label, opts)
        _ -> module.form_text(label, opts)
      end 
      |> raw()
    else
      "<span class='editable-click' phx-click='focus' phx-value-focusid='#{optid}' #{target}>#{label}</span>"
      |> raw()
    end
  end

  def set_framework(framework_module) do
    Application.put_env(:phoenix_live_editable, :css_framework, framework_module)
  end

  defp css_framework_module do
    case Application.fetch_env(:phoenix_live_editable, :css_framework) do
      {:ok, module} -> 
        module
      error ->
        IO.inspect "+++++++++++++++++++++++++++++++++++++++"
        IO.inspect "ERROR CSS FRAMEWORK MODULE"
        IO.inspect error
        IO.inspect "+++++++++++++++++++++++++++++++++++++++"
        Phoenix.LiveEditable.Bootstrap5
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Phoenix.LiveEditable

      def handle_event("focus", %{"focusid" => focusid}, socket) do
        {:noreply, assign(socket, focus: focusid)}
      end

      def handle_event("cancel", payload, socket) do
        {:noreply, assign(socket, focus: nil)}
      end
    end
  end
end
