shared_examples_for :redirects_to_the_root_path do
  it "redirects to the root path" do
    expect(subject).to redirect_to(root_path)
  end
end

shared_examples_for :renders_the_index_template do
  it "renders the :index template" do
    subject
    expect(response).to render_template(:index)
  end
end

shared_examples_for :renders_the_show_template do
  it "renders the :show template" do
    subject
    expect(response).to render_template(:show)
  end
end

shared_examples_for :renders_the_new_template do
  it "renders the :new template" do
    subject
    expect(response).to render_template(:new)
  end
end

shared_examples_for :renders_the_edit_template do
  it "renders the :edit template" do
    subject
    expect(response).to render_template(:edit)
  end
end

shared_examples_for :renders_nothing_with_status_400 do
  it "renders nothing with status 400" do
    subject
    expect(response.status).to be 400
    expect(response.body).to   be_blank
  end
end
